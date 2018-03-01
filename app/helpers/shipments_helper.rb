module ShipmentsHelper
  def shipment_status_for(shipment)
    return case shipment.status
    when 'pending' then 'Pendiente'
    when 'preparing' then 'En preparación'
    when 'route' then 'En ruta'
    when 'delivered' then 'Entregado'
    end
  end
end
