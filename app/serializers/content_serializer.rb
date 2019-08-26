class ContentSerializer
  include FastJsonapi::ObjectSerializer
  set_id :id
  attributes :title
end