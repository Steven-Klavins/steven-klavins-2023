def fill_in_trix_editor(id, content)
  find(:xpath, "//*[@id='#{id}']", visible: false).set(content)
end

def find_trix_editor(id)
  find(:xpath, "//*[@id='#{id}']", visible: false)
end