module Lama
  # Represents shopping cart, where user can add products, remove products, etc
  # Cart is binded to session, so it is usable only inside controllers and views
  class Cart
    def initialize(controller)
      self.controller = controller
    end

    # Make all missing methods be proxied to actual cart (UserProduct storage)
    def method_missing(method, *args, &block)
      get.send(method, *args, &block)
    end

    # Get the actual cart storage based on authorized user
    def get
      if controller.user_signed_in?
        controller.current_user.cart_user_products
      elsif controller.shadow_signed_in?
        controller.current_shadow_user.cart_user_products
      else
        session
      end
    end

    # Add product to cart
    def add(product)
      if !product || product.new_record?
        raise I18n.t 'lama.cart.add_not_existing_product'
      end

      if controller.user_signed_in?
        add_to_db(product, controller.current_user)
      elsif controller.shadow_signed_in?
        add_to_db(product, controller.current_shadow_user)
      else
        add_to_session(product)
      end
    end

    # Remove product from cart
    def remove(product, quantity = 1)
      if !product || product.new_record?
        raise I18n.t 'lama.cart.product_does_not_exist'
      end

      user_product = get.where(product_id: product.id).first
      if user_product.present?
        if user_product.quantity > quantity
          user_product.decrement!(:quantity, quantity)
        else
          user_product.delete
        end
      end
    end

    # Get session cart storage
    def session
      controller.session[:cart] ||= []
      UserProduct.where(id: controller.session[:cart]).all
    end

    # Set user_id to all items in session cart
    def transfer_to_user(user)
      session.each do |user_product|
        user_product.update_attributes user_id: user.id
      end
      controller.session[:cart] = [] if Lama.clear_session_cart_after_sign_in
    end

    private

    # Controller that cart is binded to
    attr_accessor :controller

    # Cart of unauthorized user is stored in a session and database
    def add_to_session(product)
      if controller.session[:cart]
        user_product = UserProduct.where(id: controller.session[:cart], product_id: product.id).first
        if user_product.nil?
          user_product = UserProduct.create(product_id: product.id)
        else
          user_product.increment!(:quantity)
        end
      else
        user_product = UserProduct.create(product_id: product.id)
        controller.session[:cart] = []
      end
      controller.session[:cart] << user_product.id
    end

    # Cart of authorized user is stored only in database
    def add_to_db(product, user)
      user_product = UserProduct.where(user_id: user.id, product_id: product.id).first
      if user_product.nil?
        UserProduct.create(user_id: user.id, product_id: product.id)
      else
        user_product.increment!(:quantity)
      end
    end
  end
end
