class PendingOrphan < ActiveRecord::Base
  belongs_to :pending_orphan_list

  def to_orphan
    orphan = Orphan.new
    fields = attributes
    ['original_address_', 'current_address_'].each do |i|
      address_fields = fields.select { |k, _| k[i] }.map { |k, v| [(k.to_s.gsub i, ''), v] }.to_h
      address_fields['province'] = Province.find_by_code(address_fields['province'])
      orphan.send "#{i.chop}=", Address.new(address_fields)
    end
    orphan.attributes = fields.reject { |k, _| k['address'] || k['pending'] }
    orphan
  end

end
