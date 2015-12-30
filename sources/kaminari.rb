generate 'kaminari:config'

file_inject('app/helpers/application_helper.rb',
  'module ApplicationHelper',
  "
  def paginate(objects, options = {})
    options.reverse_merge!(theme: 'twitter-bootstrap-3')
    super(objects, options)
  end
  ",
  :after
)
