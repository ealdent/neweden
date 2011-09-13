module Account
  def account_status
    xml = request('/account/AccountStatus.xml.aspx', :post)
    OpenStruct.new({
      :paid_until => DateTime.parse((xml/:paidUntil).inner_text).to_time,
      :create_date => DateTime.parse((xml/:createDate).inner_text).to_time,
      :logon_count => (xml/:logonCount).inner_text.to_i,
      :logon_minutes => (xml/:logonMinutes).inner_text.to_i
    })
  end

  def api_key_info
    raise "Not implemented"
  end
end
