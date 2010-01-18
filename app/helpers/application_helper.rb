module ApplicationHelper
  def body_class
    "#{controller.controller_name} #{controller.controller_name}-#{controller.action_name}"
  end

  def title(title = nil)
    @title = title || 'CollEDGE'
  end
end
