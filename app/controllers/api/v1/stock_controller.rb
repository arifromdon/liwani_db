module Api::V1
	class StockController < Api::ApplicationController

		def index
			json_response({data: example})
		end

		private

		def example
			return [
				{
					"id": 1,
					"stock": 10,
					"product": "kopi arabica"
				},
				{
					"id": 2,
					"stock": 10,
					"product": "kopi robusta"
				}
			]
		end
	end
end
