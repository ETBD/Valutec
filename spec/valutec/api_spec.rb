require 'httpparty'

module Valutec
  class Api

      def make_api_call(method,params={})
      params.merge!(
        {"ClientKey" => client_key,
          "TerminalID" => terminal_id,
          "ServerID" => server_id,
          "Identifier" => identifier}
        )
      self.class.get(method,{query: params})
    end
  end
end

