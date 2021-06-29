class BankinApi

  def initialize
    @create_url = "https://sync.bankin.com/v2/users".freeze
    @list_url = "https://sync.bankin.com/v2/users".freeze
    @authenticate_url = "https://sync.bankin.com/v2/authenticate".freeze
    @sync_item_url = "https://sync.bankin.com/v2/connect/items/add/url".freeze
    @list_updated_transactions_url = "https://sync.bankin.com/v2/transactions/updated?since=2019-06-21T18:44:09.523Z&limit=12"
    @connect_an_item_url = "https://sync.bankin.com/v2/connect/items/add/url?country=fr&capabilities=ais,bulk_tranfer"
    @list_items_url = "https://sync.bankin.com/v2/items?limit=100"
    @list_accounts_url = "https://sync.bankin.com/v2/accounts?limit=10"
    @get_account_url = "https://sync.bankin.com/v2/accounts/24995965"
    @list_transaction_by_account_url = "https://sync.bankin.com/v2/accounts/24995965/transactions?limit=12&until=2021-06-28" #until today
    @list_categories_url = "https://sync.bankin.com/v2/categories?limit=12"

  end

  def create_b(headers, credentials)
    data = HTTP.post(@create_url, headers: headers, json: credentials).parse
  end

  def authenticate_b(headers, credentials)
    data = HTTP.post(@authenticate_url, headers: headers, json: credentials).parse
  end

  def list_b(headers)
    data = HTTP.get(@list_url, headers: headers).parse
  end

  def sync_item_b(headers, access_token)
    data = HTTP.auth(access_token).get(@sync_item_url, headers: headers).parse
  end

  def list_transactions_b(headers, access_token)
    data = HTTP.auth(access_token).get(@list_transaction_by_account_url, headers: headers).parse
  end

  def connect_item_b(headers, access_token)
    data = HTTP.auth(access_token).get(@connect_an_item_url, headers: headers).parse
  end

  def list_items_b(headers, access_token)
    HTTP.auth(access_token).get(@list_items_url, headers: headers).
    parse
  end

  def list_accounts_b(headers, access_token)
    HTTP.auth(access_token).get(@list_accounts_url, headers: headers).
    parse
  end

  def get_account_b(headers, access_token)
    HTTP.auth(access_token).get(@get_account_url, headers: headers).
    parse
  end

  def list_categories_b(headers)
    HTTP.get(@list_categories_url, headers: headers).parse
  end

  def single_category_b(headers, category_id)
    single_category_url = "https://sync.bankin.com/v2/categories/#{category_id}"
    HTTP.get(single_category_url, headers: headers).parse
  end

  # def single_item_b(headers, access_token)
  #   HTTP.auth(access_token).get()
  # end
end
