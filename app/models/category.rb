class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '音楽' }, { id: 2, name: 'ゲームアプリ' }, { id: 3, name: 'キャラクター' },
    { id: 4, name: '俳優・女優' }, { id: 5, name: '食べ物' }, { id: 6, name: '動物' },
    { id: 7, name: 'スポーツ' }, { id: 8, name: '本' }, { id: 9, name: '場所' },
    { id: 10, name: 'お菓子' }, { id: 11, name: 'お酒' }, { id: 12, name: '飲食店' },
    { id: 13, name: '歌手' }, { id: 14, name: 'YouTuber' }, { id: 15, name: 'お笑い芸人' }
  ]
end
