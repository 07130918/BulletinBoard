require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #new' do
    before { get :new }
    
    it 'レスポンスコードが200である場合' do
      expect(response).to have_http_status(:ok)
    end
    
    it 'newテンプレートをレンダリングすること' do
      # gem 'rails-controller-testing'でrender_templateを使用可能
      # レンダリングの確認
      expect(response).to render_template :new
    end
    
    it '新しいUserオブジェクトがviewに渡されること' do
      expect(assigns(:user)).to be_a_new User
    end
  end

  describe 'POST #create' do
    before do
      @referer = 'http://localhost:3000'
      @request.env['HTTP_REFERER'] = @referer
    end

    context '正しいユーザー情報がわたってきた場合' do
      let(:params) do
        { user: {
          name: 'user',
          password: 'password',
          password_confirmation: 'password',
        }
      }
      end

      it 'ユーザーが1人増えていること' do
        expect { post :create, params: params }.to change(User, :count).by(1)
      end

      it 'マイページにリダイレクトされる事' do
        expect(post :create, params: params).to redirect_to(mypage_path)
      end
    end

    context 'パラメーターに正しいユーザー名、確認パスワードが含まれていない場合' do
     before do
      post(:create, params: {
        user: {
          name: 'UserNo.1',
          password: 'password',
          password_confirmation: 'invalid_password',
        }
      })
      end

      it 'リファラーにリダイレクトされる事' do
        expect(response).to redirect_to(@referer)
      end

      it 'ユーザー名にエラーメッセージが含まれていること' do
        expect(flash[:error_messages]).to include 'ユーザー名は小文字英数字で入力してください'
      end

      it 'パスワード確認のエラーメッセージが含まれてること' do
        expect(flash[:error_messages]).to include 'パスワード(確認)とパスワードの入力が一致しません'
      end
    end
  end
end
