module Eve
  def alliance_list
    request("/eve/AllianceList.xml.aspx")
  end
end
