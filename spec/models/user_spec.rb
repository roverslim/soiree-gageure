# frozen_string_literal: true

require 'rails_helper'

RSpec.describe(User, type: :model) do
  let(:user) do
    User.create!(
      email: 'abc@def.com',
      password: 'foo',
    )
  end

  describe('#valid?') do
    it('requires :email to be present') do
      new_user = User.new

      with_locale(:en) do
        new_user.valid?
        expect(new_user.errors[:email]).to include("can't be blank")
      end

      with_locale(:fr) do
        new_user.valid?
        expect(new_user.errors[:email]).to include("ne peut pas être vide")
      end
    end

    it('requires :email to be unique') do
      new_user = User.new(email: user.email)

      with_locale(:en) do
        new_user.valid?
        expect(new_user.errors[:email]).to include('has already been taken')
      end

      with_locale(:fr) do
        new_user.valid?
        expect(new_user.errors[:email]).to include('a déjà été assigné')
      end
    end

    it('requires :password to be present on create') do
      new_user = User.new

      with_locale(:en) do
        new_user.valid?
        expect(new_user.errors[:password]).to include("can't be blank")
      end

      with_locale(:fr) do
        new_user.valid?
        expect(new_user.errors[:password]).to include("ne peut pas être vide")
      end
    end

    it('requires :password to be at least 3 chars long on create') do
      new_user = User.new(password: 'a')

      with_locale(:en) do
        new_user.valid?
        expect(new_user.errors[:password]).to include('is too short (minimum is 3 characters)')
      end

      with_locale(:fr) do
        new_user.valid?
        expect(new_user.errors[:password]).to include('est trop court (minimum de 3 charactères)')
      end

      new_user.password = 'foo'
      new_user.valid?
      expect(new_user.errors[:password]).to be_empty
    end

    it('does not require :password to be provided on update') do
      user.valid?
      expect(user.errors[:password]).to be_empty
    end

    it('requires :password to be at least 3 chars long on update') do
      user.password = 'a'

      with_locale(:en) do
        user.valid?
        expect(user.errors[:password]).to include('is too short (minimum is 3 characters)')
      end

      with_locale(:fr) do
        user.valid?
        expect(user.errors[:password]).to include('est trop court (minimum de 3 charactères)')
      end

      user.password = 'foo'
      user.valid?
      expect(user.errors[:password]).to be_empty
    end
  end
end
