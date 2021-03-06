# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'records/new', type: :view do
  before(:each) do
    assign(:record, build(:record))
  end

  it 'renders new record form' do
    render
    assert_select 'form[action=?][method=?]', records_path, 'post' do
      assert_select 'input[name=?]', 'record[title]'
      assert_select 'input[name=?]', 'record[year]'
      assert_select 'select[name=?]', 'record[condition]'
      assert_select 'select[name=?]', 'record[artist_id]'
    end
  end
end
