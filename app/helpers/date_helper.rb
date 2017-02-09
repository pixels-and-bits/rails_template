module DateHelper

  def short_date(date)
    return date unless date.respond_to?(:strftime)

    month = date.strftime('%B')
    day = date.strftime('%e').to_i.ordinalize

    "#{month} #{day}"
  end

  def long_date(date)
    return date unless date.respond_to?(:strftime)

    month = date.strftime('%B')
    day = date.strftime('%e').to_i.ordinalize
    year = date.year

    "#{month} #{day}, #{year}"
  end

  def long_date_with_zone(date)
    return date unless date.respond_to?(:strftime)

    date.strftime('%B %e at %r %Z')
  end

  def short_date_with_zone(date)
    return date unless date.respond_to?(:strftime)

    date.strftime('%b %e at %r %Z')
  end

end
