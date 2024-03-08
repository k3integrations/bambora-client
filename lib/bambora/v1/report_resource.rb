# frozen_string_literal: true

module Bambora
  module V1
    ##
    # For making requests to the /profiles endpoint
    class ReportResource
      attr_reader :client, :api_key, :sub_path

      ##
      # Instantiate an interface to make requests against Bambora's Profiles API.
      #
      # @example
      #
      #   client = Bambora::Rest::JSONClient(base_url: '...', api_key: '...', merchant_id: '...')
      #   reports = Bambora::V1::ReportResource(client: client)
      #
      #   # Start making requests ...
      #
      # @param client [Bambora::Rest::JSONClient] An instance of Bambora::JSONClient, used to make network requests.
      def initialize(client:, api_key:)
        @client = client
        @api_key = api_key
        @sub_path = '/v1/reports'
      end

      ##
      # Query for transactions using a date range and optional search criteria
      #
      # @example
      #
      #   client = Bambora::Rest::JSONClient(base_url: '...', api_key: '...', merchant_id: '...')
      #   reports = Bambora::V1::ReportResource(client: client)
      #
      #   search_query = {
      #     name:       'Search',
      #     start_date: start_date.beginning_of_day.strftime('%Y-%m-%dT%H:%M:%S'),
      #     end_date:   end_date.end_of_day.strftime('%Y-%m-%dT%H:%M:%S'),
      #     start_row:,
      #     end_row:    start_row + page_size - 1,
      #   }
      #
      #   reports.post(search_query_data: search_query)
      #   # => {
      #   #   :records => [
      #   #     {
      #   #       :row_id => 1,
      #   #       :trn_id => 1,
      #   #       :trn_date_time => "",
      #   #       :trn_type => "",
      #   #       :trn_order_number => "",
      #   #       :trn_payment_method => "",
      #   #       :trn_comments => "",
      #   #       :trn_masked_card => "",
      #   #       :trn_amount => 1,
      #   #       :trn_returns => 1,
      #   #       :trn_completions => 1,
      #   #       :trn_voided => 1,
      #   #       :trn_response => 1,
      #   #       :trn_card_type => "",
      #   #       :trn_batch_no => 1,
      #   #       :trn_avs_result => "",
      #   #       :trn_cvd_result => 1,
      #   #       :trn_cavv_result => "",
      #   #       :trn_card_expiry => "",
      #   #       :message_id => 1,
      #   #       :message_text => "",
      #   #       :trn_card_owner => "",
      #   #       :trn_ip => "",
      #   #       :trn_approval_code => "",
      #   #       :trn_reference => 1,
      #   #       :b_name => "",
      #   #       :b_email => "",
      #   #       :b_phone => "",
      #   #       :b_address1 => "",
      #   #       :b_address2 => "",
      #   #       :b_city => "",
      #   #       :b_province => "",
      #   #       :b_postal => "",
      #   #       :b_country => "",
      #   #       :s_name => "",
      #   #       :s_email => "",
      #   #       :s_phone => "",
      #   #       :s_address1 => "",
      #   #       :s_address2 => "",
      #   #       :s_city => "",
      #   #       :s_province => "",
      #   #       :s_postal => "",
      #   #       :s_country => "",
      #   #       :ref1 => "",
      #   #       :ref2 => "",
      #   #       :ref3 => "",
      #   #       :ref4 => "",
      #   #       :ref5 => "",
      #   #       :product_name => "",
      #   #       :product_id => "",
      #   #       :customer_code => "",
      #   #       :currency_abbr => "",
      #   #       :merchant_id => 1,
      #   #       :merchant_name => "",
      #   #       :entry_method => "",
      #   #       :authorizing_merchant_id => 1
      #   #     }
      #   #   ]
      #   # }
      #
      # @param search_query_data [Hash] A hash of search criteria including the date range.
      #
      # @return [Array] An array of hashes showing the transaction details.
      def post(search_query_data:)
        client.post(path: sub_path, body: search_query_data, api_key: @api_key)
      end

      ##
      # Query for settlement reports between a date range
      #
      # @example
      #
      #   client = Bambora::Rest::JSONClient(base_url: '...', api_key: '...', merchant_id: '...')
      #   reports = Bambora::V1::ReportResource(client: client)
      #
      #   search_query = {
      #     start_date: start_date.beginning_of_day.strftime('%Y-%m-%dT%H:%M:%S'),
      #     end_date:   end_date.end_of_day.strftime('%Y-%m-%dT%H:%M:%S'),
      #   }
      #
      #   reports.settlemnt(search_query: search_query)body
      #   data => [
      #      {
      #        merchant_id : number
      #        transactions_date : string
      #        currency : string
      #        settlement_net_amount : number
      #        settlement_state : string
      #        settlement_date : string
      #        approved_transaction_count : number
      #        declined_transaction_count : number
      #        sale_amount_total : number
      #        returned_amount_total : number
      #        chargebacks_count : number
      #        chargebacks_amount_total : number
      #        card_transaction_approved_rate : number
      #        card_transaction_declined_rate : number
      #        card_discount_rate : number
      #        gst_tax_rate : number
      #        approved_transaction_fee_total : number
      #        declined_transaction_fee_total : number
      #        discount_rate_fee_total : number
      #        chargeback_fee_total : number
      #        gst_tax_fee_total : number
      #        reserves_held : number
      #        reserves_released : number
      #        reserves_forward : number
      #      }
      #   ]
      #

      def settlement(search_query:)
        client.get(path: "#{sub_path}/settlement", params: search_query, api_key: @api_key)
      end
    end
  end
end
