module ProductsHelper
  def coffee_name_for(coffee_type)
    return case coffee_type
    when 'peru_geisha' then 'Perú Geisha'
    when 'brasil_bruzzi' then 'Brasil Bruzzi'
    when 'nicaragua_gavilan' then 'Nicaragua Gavilán'
    when 'brasil_bourbon' then 'Brasil Bourbon'
    when 'guatemala_huehue' then 'Huehue - Guatemala'
    when 'guatemala_antigua' then 'Antigua - Guatemala'
    end
  end
end
