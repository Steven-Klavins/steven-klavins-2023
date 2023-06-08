require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the BlogsHelper. For example:
#
# describe BlogsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end

# Helpers for Action Text tests.

def fill_in_trix_editor(id, content)
  find(:xpath, "//*[@id='#{id}']", visible: false).set(content)
end

def find_trix_editor(id)
  find(:xpath, "//*[@id='#{id}']", visible: false)
end