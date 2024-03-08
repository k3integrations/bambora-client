# frozen_string_literal: true

require 'spec_helper'

module Bambora
  module V1
    describe ReportResource do
      let(:api_key) { 'fakekey' }
      let(:merchant_id) { 1 }
      let(:sub_merchant_id) { 2 }
      let(:base_url) { 'https://sandbox-api.na.bambora.com' }
      let(:headers) { { 'Authorization' => 'Passcode MTpmYWtla2V5', 'Sub-Merchant-ID' => sub_merchant_id } }
      let(:response_headers) { { 'Content-Type' => 'application/json' } }
      let(:response_body) do
        { records: [{
          row_id: 1,
          trn_id: 1,
          trn_date_time: '',
          trn_type: '',
          trn_order_number: '',
          trn_payment_method: '',
          trn_comments: '',
          trn_masked_card: '',
          trn_amount: 1,
          trn_returns: 1,
          trn_completions: 1,
          trn_voided: 1,
          trn_response: 1,
          trn_card_type: '',
          trn_batch_no: 1,
          trn_avs_result: '',
          trn_cvd_result: 1,
          trn_cavv_result: '',
          trn_card_expiry: '',
          message_id: 1,
          message_text: '',
          trn_card_owner: '',
          trn_ip: '',
          trn_approval_code: '',
          trn_reference: 1,
          b_name: '',
          b_email: '',
          b_phone: '',
          b_address1: '',
          b_address2: '',
          b_city: '',
          b_province: '',
          b_postal: '',
          b_country: '',
          s_name: '',
          s_email: '',
          s_phone: '',
          s_address1: '',
          s_address2: '',
          s_city: '',
          s_province: '',
          s_postal: '',
          s_country: '',
          ref1: '',
          ref2: '',
          ref3: '',
          ref4: '',
          ref5: '',
          product_name: '',
          product_id: '',
          customer_code: '',
          currency_abbr: '',
          merchant_id: 1,
          merchant_name: '',
          entry_method: '',
          authorizing_merchant_id: 1,
        }] }
      end
      let(:client) do
        Bambora::Rest::JSONClient.new(
          base_url: base_url,
          merchant_id: merchant_id,
          sub_merchant_id: sub_merchant_id,
        )
      end

      subject { described_class.new(client: client, api_key: api_key) }

      describe '#reports' do
        before(:each) do
          stub_request(:post, "#{base_url}/v1/reports").with(
            body: search_query.to_json.to_s,
            headers: headers,
          ).to_return(headers: response_headers, body: response_body.to_json.to_s)
        end

        let(:search_query) do
          {
            name: '',
            start_date: '',
            end_date: '',
            start_row: '',
            end_row: '',
            criteria: [{ field: 1, operator: '', value: '' }],
          }
        end

        it "POST's to the Bambora API" do
          subject.post(search_query_data: search_query)

          expect(
            a_request(:post, "#{base_url}/v1/reports").with(
              body: search_query.to_json.to_s,
              headers: headers,
            ),
          ).to have_been_made.once
        end
      end

      describe '#settlement' do
        before(:each) do
          stub_request(:get, "#{base_url}/v1/reports/settlement?end_date=&start_date=").with(
            headers: headers,
          ).to_return(headers: response_headers, body: response_body.to_json.to_s)
        end

        let(:search_query) do
          {
            start_date: '',
            end_date: '',
          }
        end

        let(:response_body) do
          {
            merchant_id: 1,
            transactions_date: "",
            currency: "",
            settlement_net_amount: 1,
            settlement_state: "",
            settlement_date: "",
            approved_transaction_count: 1,
            declined_transaction_count: 1,
            sale_amount_total: 1,
            returned_amount_total: 1,
            chargebacks_count: 1,
            chargebacks_amount_total: 1,
            card_transaction_approved_rate: 1,
            card_transaction_declined_rate: 1,
            card_discount_rate: 1,
            gst_tax_rate: 1,
            approved_transaction_fee_total: 1,
            declined_transaction_fee_total: 1,
            discount_rate_fee_total: 1,
            chargeback_fee_total: 1,
            gst_tax_fee_total: 1,
            reserves_held: 1,
            reserves_released: 1,
            reserves_forward: 1
          }
        end

        it "GET's to the Bambora API" do
          subject.settlement(search_query:)

          expect(
            a_request(:get, "#{base_url}/v1/reports/settlement?end_date=&start_date=").with(
              headers: headers,
            ),
          ).to have_been_made.once
        end
      end
    end
  end
end
