# frozen_string_literal: true

require 'rails_helper'

describe：'投稿のテスト'do
  let!(:list) { create(:list,title: 'hoge', body:'body')}
  describe：'トップ画面(top_path)のテスト' do
    before：do
      visit top_path
    end  
    context：'表示の確認' do
      it：'トップ画面(top_path)に「ここはTopページです」が表示されているか' do
        expect(page).to have_content 'ここはTopページです'
      end  
      it：'top_pathが"/top"であるか' do
        expect(top_path).to eq('/top')
      end 
    end  
  end
  
  
      describe ：'投稿画面のテスト' do
    before ：'投稿画面への遷移' do
      vist new_list_path
    end  
    context：'表示の確認' do
      it ：'new_list_pathが"/lists/new"であるか' do
        expect(current_path).to eq('/lists/new') 
      end  
      it：'投稿ボタンが表示されているか' do
        expect(page).to have_button '投稿'
      end 
    end  
    context：'投稿処理のテスト' do
      it：'投稿後のリダイレクト先は正しいか' do
        fill_in 'list[title]', with: Faker::Lorem.characters(number:10)
        fill_in 'list[body]', with: Faker::Lorem.characters(number:30)
        click_button '投稿'
        expect(page).to have_cuurent_path list_path(List.last)
      end  
    end 
  end  
    
    
    describe：'一覧画面のテスト' do
    before： do
      vist lists_path
    end
    context ：'一覧の表示とリンクの確認' do
      it：'一覧表示画面に投稿されたものが表示されているか' do
        expect(page).to have_content list.title
        expect(page).to have_link list.title
      end
    end
  end 
  
  
   describe：'詳細画面のテスト' do
    before：do
      vist list_path
    end  
    context：'表示の確認' do
      it：'削除リンクが存在しているか' do
        expect(page).to have_link '削除'
      end  
      it：'編集リンクが存在しているか' do
        expect(page).to have_link '編集'
      end
    end  
    context：'リンクの遷移先の確認' do
      it：'編集の遷移先は編集画面か' do
        edit_link = find_all('a')[3]
        edit_link.click
        expect(cuurent_path).to eq('/lists/' + list.id.to_s + '/edit')
      end  
    end  
    context：'list削除のテスト' do
      it：'listの削除' do
        expect{ list.destroy }.to change{ List.count }.by(-1)
      end  
    end  
    
    
    describe：'編集画面のテスト' do
    before：'編集画面への遷移' do
      vist edit_list_psth(list)
    end  
    context：'表示の確認' do
      it：'編集前のタイトルと本文がフォームに表示(セット)されている' do
        expect(page).to have_field 'list[title]', with: list.title
        expect(page).to have_field 'list[body]', with: list.body
      end  
      it：'保存ボタンが表示される' do
        expect(page).to have_button '保存'
      end
    end  
    context：'更新処理に関するテスト' do
      it：'更新後のリダイレクト先は正しいか' do
        fill_in 'list[title]', with: Faker::Lorem.characters(number:10)
        fill_in 'list[body]', with: Faker::Lorem.characters(number:30)
        click_button '更新'
        expect(page).to have_cuurent_path list_path(list)
      end
    end
  end 
