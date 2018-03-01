# == Schema Information
#
# Table name: shipping_addresses
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  city           :string(255)
#  town           :string(255)
#  address        :text
#  address_number :string(255)
#  comments       :text
#  receiver_name  :string(255)
#  created_at     :datetime
#  updated_at     :datetime
#

class ShippingAddress < ActiveRecord::Base
  TOWNS = [["Alhué", "Alhué"], ["Buin", "Buin"], ["Calera de Tango", "Calera de Tango"], ["Cerrillos", "Cerrillos"], ["Cerro Navia", "Cerro Navia"], ["Colina", "Colina"], ["Conchalí", "Conchalí"], ["Curacaví", "Curacaví"], ["El Bosque", "El Bosque"], ["El Monte", "El Monte"], ["Estación Central", "Estación Central"], ["Huechuraba", "Huechuraba"], ["Independencia", "Independencia"], ["Isla de Maipo", "Isla de Maipo"], ["La Cisterna", "La Cisterna"], ["La Florida", "La Florida"], ["La Granja", "La Granja"], ["La Pintana", "La Pintana"], ["La Reina", "La Reina"], ["Lampa", "Lampa"], ["Las Condes", "Las Condes"], ["Lo Barnechea", "Lo Barnechea"], ["Lo Espejo", "Lo Espejo"], ["Lo Prado", "Lo Prado"], ["Macul", "Macul"], ["Maipú", "Maipú"], ["María Pinto", "María Pinto"], ["Melipilla", "Melipilla"], ["Ñuñoa", "Ñuñoa"], ["Padre Hurtado", "Padre Hurtado"], ["Paine", "Paine"], ["Pedro Aguirre Cerda", "Pedro Aguirre Cerda"], ["Peñaflor", "Peñaflor"], ["Peñalolén", "Peñalolén"], ["Pirque", "Pirque"], ["Providencia", "Providencia"], ["Pudahuel", "Pudahuel"], ["Puente Alto", "Puente Alto"], ["Quilicura", "Quilicura"], ["Quinta Normal", "Quinta Normal"], ["Recoleta", "Recoleta"], ["Renca", "Renca"], ["San Bernardo", "San Bernardo"], ["San Joaquín", "San Joaquín"], ["San José de Maipo", "San José de Maipo"], ["San Miguel", "San Miguel"], ["San Pedro", "San Pedro"], ["San Ramón", "San Ramón"], ["Santiago", "Santiago"], ["Talagante", "Talagante"], ["Tiltil", "Tiltil"], ["Vitacura", "Vitacura"]]

  belongs_to :user
  belongs_to :commune
  has_many :orders

  validates :town, :address, presence: true

  def full_address
    full_address = "#{address.titleize}"
    full_address << ", #{address_number_2}" if address_number_2
    full_address << ", #{commune.name}"
    full_address
  end

end
