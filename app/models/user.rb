class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :role, presence: true, inclusion: { in: %w[user admin] }
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }

  def admin?
    role == 'admin'
  end

  def user?
    role == 'user'
  end

  def self.roles
    { 'user' => 'user', 'admin' => 'admin' }
  end

  after_initialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.role ||= 'user'
  end
end
