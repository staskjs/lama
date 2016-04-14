module Lama
  module Helpers
    def parsed_body
      JSON.parse(response.body)
    end
  end
end
