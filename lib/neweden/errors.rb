module NewEden
  module Errors
    class TimeoutError < StandardError; end
    class AuthenticationError < StandardError; end
    class NoResponseError < StandardError; end
    class UnsuccessfulResponseError < StandardError; end
    class NotFoundError < StandardError; end
    class ApiError < StandardError; end
    class XMLParsingError < StandardError; end
    class NotInvolvedInFactionalWarfare < StandardError; end
  end
end