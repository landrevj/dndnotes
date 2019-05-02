class User < ApplicationRecord
  after_create :create_deafult_workspace

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 25 }

  has_many :workspaces, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :notes, dependent: :destroy
  has_many :links, dependent: :destroy

  has_one :active_workspace, -> { where(active: true) }, class_name: 'Workspace'

  private

  def create_deafult_workspace
    workspaces.create(name: 'Default Workspace', active: true)
  end
end
