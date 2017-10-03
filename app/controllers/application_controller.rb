class ApplicationController < ActionController::API
  include ActionController::Serialization
  include Swagger::Docs::ImpotentMethods
  Swagger::Docs::Generator::set_real_methods

  def pagination_dict(collection)
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.prev_page, # use collection.previous_page when using will_paginate
      total_pages: collection.total_pages,
      total_count: collection.total_count
    }
  end

  class << self
    Swagger::Docs::Generator::set_real_methods
  end
end
