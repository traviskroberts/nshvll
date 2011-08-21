class Member < ActiveRecord::Base
  has_and_belongs_to_many :categories

  validates_presence_of :name, :email, :url
  validates_attachment_presence :image
  validates_uniqueness_of :email, :on => :create, :message => "That email has been used by another member."
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_format_of :url, :with => /^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$/ix

  before_create :generate_activation_code

  scope :recent, order('created_at DESC').limit(5)
  scope :approved, where('active = ?', true)

  has_attached_file :image,
                    :styles => { :normal => '200x200#', :small => '100x100#' },
                    :default_style => :normal,
                    :url => "/system/:class/:attachment/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/system/:class/:attachment/:id/:style/:basename.:extension"

  def self.find_by_activation(activation_code)
    self.where('activation = ?', activation_code).first
  end

  def self.find_by_edit_code(code)
    now = Time.now
    cutoff = now - 1800 # edit link is only good for 30 minutes
    self.where('edit_code = ? AND edit_time BETWEEN ? AND ?', code, cutoff, now).first
  end

  def generate_activation_code
    # let's make sure the activation code is SUPER unique
    chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ23456789'
    salt = ''
    20.times { |i| salt << chars[rand(chars.length)] }

    code = Digest::SHA1.hexdigest(Time.now.to_s + salt)

    self.activation = code
  end

  def generate_edit_code
    # let's make sure the edit code is SUPER unique
    chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ23456789'
    salt = ''
    20.times { |i| salt << chars[rand(chars.length)] }

    code = Digest::SHA1.hexdigest(self.email + salt)

    self.update_attributes(:edit_code => code, :edit_time => Time.now)
  end
end
