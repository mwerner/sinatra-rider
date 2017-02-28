require "spec_helper"

describe Sinatra::Rider::Authentication do
  describe 'Routing' do
    context '/login' do
      describe 'form' do
        before { get('/login') }

        it 'should be successful' do
          expect(last_response.status).to eq(200)
        end

        it 'should render the default login page' do
          expect(last_response.body).to match('id="login-form"')
        end
      end

      describe 'submission' do
        before { post('/login', username: 'foo', password: 'bar') }

        it 'should redirect' do
          # TODO
        end
      end
    end

    context '/logout' do
      before { get('/logout') }

      it 'should redirect' do
        expect(last_response.status).to eq(302)
      end
    end

    context '/signup' do
      describe 'form' do
        before { get('/signup') }

        it 'should be successful' do
          expect(last_response.status).to eq(200)
        end

        it 'should render the default login page' do
          expect(last_response.body).to match('id="signup-form"')
        end
      end

      describe 'submission' do
        before { post('/signup', username: 'foo', name: 'bar', password: 'baz') }

        it 'should redirect' do
          expect(last_response.status).to eq(302)
        end
      end
    end
  end
end
