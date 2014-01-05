require "active_record"

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"

ActiveRecord::Base.connection_pool.with_connection do |connection|
  connection.create_table :models do |t|
    t.string :name
    t.timestamps
  end

  connection.add_index :models, :name, :unique => true
end

class Model < ActiveRecord::Base
end

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'

  config.around(:each) do |example|
    ActiveRecord::Base.connection_pool.with_connection do
      ActiveRecord::Base.transaction do
        example.call
        raise ActiveRecord::Rollback
      end
    end
  end

  config.before(:suite) do
    ActiveRecord::Base.connection_pool.with_connection do
      ActiveRecord::Base.connection.execute("DELETE FROM models")
    end
  end
end


describe Model do
  it "is isolated" do
    Model.count.should == 0
    Model.create!(:name => "hello")
    Model.count.should == 1
  end

  it "is really isolated" do
    Model.count.should == 0
    Model.create!(:name => "hello")
    Model.count.should == 1
  end
end

describe Model do
  it "is isolated across actors" do
    Model.count.should == 0
    Model.create!(:name => "hello")
    Model.count.should == 1
  end
end
