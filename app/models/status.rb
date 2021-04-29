class Status < ActiveHash::Base
  self.data = [
    { id:  1, name: '---' },
    { id:  2, name: '訪問依頼有' },
    { id:  3, name: '見積依頼有' },
    { id:  4, name: '完了' },
    { id:  5, name: '保留' }
  ]
  include ActiveHash::Associations
  has_many :visits
end