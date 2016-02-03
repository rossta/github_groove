module GithubGroove
  module Repositories
    module Pagination
      def self.paginate(limit: 25, page: 0)
        offset = page * limit
        query do
          limit(limit).offset(offset)
        end
      end
    end
  end
end
