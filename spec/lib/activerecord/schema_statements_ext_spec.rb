require 'spec_helper'

RSpec.describe ActiveRecord::ConnectionAdapters::SchemaStatementsExt do

  let(:table) { 'table_name' }
  let(:create_options) { 'base_options' }
  let(:current_options) { 'current_options' }
  let(:both_options) { 'current_options base_options' }
  let(:block) { TestClass.block_was_called }

  class TestClass
    include ActiveRecord::ConnectionAdapters::SchemaStatements

    def self.block_was_called
    end
  end

  before(:each) do
    expect(TestClass).to receive(:block_was_called)
    expect_any_instance_of(TestClass).to receive(:execute)
    allow_any_instance_of(TestClass).to receive_message_chain(:schema_creation, :accept)
    allow_any_instance_of(TestClass).to receive(:supports_indexes_in_create?)
    allow_any_instance_of(TestClass).to receive(:supports_comments?)
  end

  describe '#create_table' do
    # any_args is used to bridge differences between ActiveRecord versions

    context 'with create_options' do
      before(:each) do
        allow(ActiveRecord::Base).to receive(:connection_config).and_return({ create_options: create_options })
      end

      context 'with current_options' do
        it 'adds connection config to options arg and forwards to parent' do
          expect_any_instance_of(TestClass).to receive(:create_table_definition).with(
            table, nil, both_options, any_args).and_call_original

          TestClass.new.create_table(table, { options: current_options }) { block }
        end
      end

      context 'without current_options' do
        it 'sends connection config as option' do
          expect_any_instance_of(TestClass).to receive(:create_table_definition).with(
            table, nil, create_options, any_args).and_call_original

          TestClass.new.create_table(table) { block }
        end
      end
    end

    context 'without create_options' do
      before(:each) do
        allow(ActiveRecord::Base).to receive(:connection_config).and_return({})
      end

      context 'with current_options' do
        it 'sends just current_options' do
          expect_any_instance_of(TestClass).to receive(:create_table_definition).with(
            table, nil, current_options, any_args).and_call_original

          TestClass.new.create_table(table, { options: current_options }) { block }
        end
      end

      context 'without current_options' do
        it 'sends no options' do
          expect_any_instance_of(TestClass).to receive(:create_table_definition).with(
            table, nil, nil, any_args).and_call_original

          TestClass.new.create_table(table) { block }
        end
      end
    end
  end
end