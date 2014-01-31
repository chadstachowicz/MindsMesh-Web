require 'spec_helper'

describe "background_jobs/new" do
  before(:each) do
    assign(:background_job, stub_model(BackgroundJob,
      :name => "MyString",
      :type => "",
      :entity_id => 1,
      :transactions => 1,
      :campaign_id => 1,
      :status => "MyString"
    ).as_new_record)
  end

  it "renders new background_job form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", background_jobs_path, "post" do
      assert_select "input#background_job_name[name=?]", "background_job[name]"
      assert_select "input#background_job_type[name=?]", "background_job[type]"
      assert_select "input#background_job_entity_id[name=?]", "background_job[entity_id]"
      assert_select "input#background_job_transactions[name=?]", "background_job[transactions]"
      assert_select "input#background_job_campaign_id[name=?]", "background_job[campaign_id]"
      assert_select "input#background_job_status[name=?]", "background_job[status]"
    end
  end
end
