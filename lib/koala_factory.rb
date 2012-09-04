class KoalaFactory
  class << self

    def new_oauth
      a=Settings.env['facebook']
      Koala::Facebook::OAuth.new(a['key'], a['secret'])
    end

    def new_graph(oauth_access_token)
      Koala::Facebook::API.new(oauth_access_token)
    end

  end
end

=begin
code examples:


@oauth.parse_signed_request(params[:signed_request])
{
  "algorithm"=>"HMAC-SHA256",
  "expires"=>1346785200,
  "issued_at"=>1346778280,
  "oauth_token"=>"AAAD565GhZADsBALInx2ZAII3Mn7uKZB8EGjkBvG33AfvOXgepfeQkRAdZB6AQIkOdZBjDcXu7o2J3YOZBoOfCZA9ZCI0yU6khwGFYBaiv6RSexMPDX70ZBubr",
  "user"=>{
            "country"=>"us",
            "locale"=>"en_US",
            "age"=>{"min"=>21}
          },
  "user_id"=>"1307529248"
}
=end