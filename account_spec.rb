require "rspec"
 
require_relative "account"
 
describe Account do
  let(:account) { Account.new("1234512345", 100) }

  describe "#initialize" do
    it "should be an instance of Account" do
      account.should be_an_instance_of Account
    end

    it "should have an account number" do
      account.acct_number.length.should eq 10
    end

    it "should accept 1 argument" do
      expect {
        Account.new("1234567891")
      }.to_not raise_error(ArgumentError)
    end

    it "should not accept more than 2 arguments" do
      expect {
        Account.new("1234567891", 2342342342, 23432432)
      }.to raise_error(ArgumentError)
    end
  end
 
  describe "#transactions" do
    it "should be an array" do
      account.transactions.class.should eq Array
    end

    it "should have a size of 1" do
      account.transactions.size.should eq 1
    end
  end
 
  describe "#balance" do
    it "should have the correct starting balance" do
      account.balance.should eq 100
    end
  end
 
  describe "#account_number" do
    it "should have the right hidden format" do
      account.acct_number.should eq "******2345"
    end
  end
 
  describe "deposit!" do
    it "should add an element to the transactions array" do
      account.deposit!(100)
      account.deposit!(50)
      account.transactions.length.should eq 3
    end

    it "should return the correct updated balance" do
      account.deposit!(100)
      account.balance.should eq 200
    end

    it "should not pass when given a negative input" do
      expect {
        account.deposit!(-100)
      }.to raise_error(NegativeDepositError)
    end

    it "should not accept more than 1 argument" do
      expect {
        account.deposit!(20, 40)
      }.to raise_error(ArgumentError)
    end
  end
 
  describe "#withdraw!" do
    it "should add an element to the transactions array" do
      account.withdraw!(10)
      account.withdraw!(20)
      account.transactions.length.should eq 3
    end

    it "should return the correct updated balance" do
      account.withdraw!(50)
      account.balance.should eq 50
    end

    it "should raise overdraft error" do
      expect {
        account.withdraw!(200)
      }.to raise_error(OverdraftError)
    end

    it "should not accept more than 1 argument" do
      expect {
        account.withdraw!(20, 40)
      }.to raise_error(ArgumentError)
    end
  end
end
