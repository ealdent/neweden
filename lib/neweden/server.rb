module Server
  def server_status
    request("/server/ServerStatus.xml.aspx")
  end
end
