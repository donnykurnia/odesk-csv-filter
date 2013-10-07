module ApplicationHelper

  def bootstrap_class_for flash_type
    {success: "alert-success", error: "alert-error", alert: "alert-block", notice: "alert-info"}[flash_type] || flash_type.to_s
  end

  def title(page_title)
    content_for(:title) { page_title }
  end

  def meta_author(meta_author)
    content_for(:meta_author) { meta_author }
  end

  def meta_keywords(meta_keywords)
    content_for(:meta_keywords) { meta_keywords }
  end

  def meta_description(meta_description)
    content_for(:meta_description) { meta_description }
  end

  def canonical_link(canonical_link)
    content_for(:canonical_link) { canonical_link }
  end

  def alternate_link(alternate_link)
    content_for(:alternate_link) { alternate_link }
  end

end
