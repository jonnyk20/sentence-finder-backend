# require 'faraday_middleware/aws_signers_v4'

require 'elasticsearch'
# require 'faraday_middleware'
require 'faraday_middleware/aws_sigv4'

host = ENV['AWS_ES_HOST'] # e.g. https://my-domain.region.es.amazonaws.com
index = 'test'
type = '_doc'
id = '1'
document = {
  year: 2007,
  title: '5 Centimeters per Second',
  info: {
    plot: 'Told in three interconnected segments, we follow a young man named Takaki through his life.',
    rating: 7.7
  }
}

region = 'us-east-2' # e.g. us-west-1
service = 'es'

Elasticsearch::Model.client = Elasticsearch::Client.new(url: host) do |f|
  f.request :aws_sigv4,
    service: service,
    region: region,
    access_key_id: ENV['AWS_ACCESS_KEY_ID'],
    secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    # session_token: ENV['AWS_SESSION_TOKEN'] # optional
end

# puts client.index index: index, type: type, id: id, body: document