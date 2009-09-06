# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def alternate_class
    @class = @class != '' ? '' : 'class="shade"'
  end

end
