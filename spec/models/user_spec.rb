# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  birthday        :date
#  name            :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do
  # describe 'テストしたいもの' メソッドは＃メソッド名
  describe '#age' do
    before do
      allow(Time.zone).to receive(:now).and_return(Time.zone.parse('2020/12/30'))
    end

    # どのような条件でテストを行うか
    context '20年前の生年月日の場合' do
      let(:user) { User.new(birthday: Time.zone.now - 20.years) }
      # itの中のexpectでメソッドがどう在れば正しいのかを判別
      it '年齢が20歳であること' do
        # Userオブジェクトのageメソッドの戻り値が20になるか検証
        # expect == eqで正しいと判断
        expect(user.age).to eq 20
      end
    end

    context '10年前に生まれた場合でちょうど誕生日の場合' do
      let(:user) { User.new(birthday: Time.zone.now.parse('2020/12/30')) }
      
      it '年齢が10歳であること' do
        expect(user.age).to eq 10
      end
    end

    context '10年前の生まれた場合で誕生日が来ていない場合' do
      let(:user) { User.new(birthday: Time.zone.now.parse('2020/12/30')) }
      
      it '年齢が9歳であること' do
        expect(user.age).to eq 9
      end
    end
  end
end
