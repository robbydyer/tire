module Tire

  module HTTP

    module Client

      class RestClient
        ConnectionExceptions = [::RestClient::ServerBrokeConnection, ::RestClient::RequestTimeout]

        def self.get(url, data=nil, timeout=-1)
          perform ::RestClient::Request.new(:method => :get, :url => url, :payload => data, :timeout => timeout).execute
        rescue *ConnectionExceptions
          raise
        rescue ::RestClient::Exception => e
          Response.new e.http_body, e.http_code
        end

        def self.post(url, data)
          perform ::RestClient.post(url, data)
        rescue *ConnectionExceptions
          raise
        rescue ::RestClient::Exception => e
          Response.new e.http_body, e.http_code
        end

        def self.put(url, data)
          perform ::RestClient.put(url, data)
        rescue *ConnectionExceptions
          raise
        rescue ::RestClient::Exception => e
          Response.new e.http_body, e.http_code
        end

        def self.delete(url)
          perform ::RestClient.delete(url)
        rescue *ConnectionExceptions
          raise
        rescue ::RestClient::Exception => e
          Response.new e.http_body, e.http_code
        end

        def self.head(url)
          perform ::RestClient.head(url)
        rescue *ConnectionExceptions
          raise
        rescue ::RestClient::Exception => e
          Response.new e.http_body, e.http_code
        end

        def self.__host_unreachable_exceptions
          [Errno::ECONNREFUSED, ::RestClient::ServerBrokeConnection, ::RestClient::RequestTimeout]
        end

        private

        def self.perform(response)
          Response.new response.body, response.code, response.headers
        end

      end

    end

  end

end
