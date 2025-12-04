require 'rails_helper'

RSpec.describe RolePolicy, type: :policy do
  let(:user) { User.new }

  subject { described_class }

  context "for a visitor" do
    let(:user) { nil }
    let(:policy) { described_class.new(user, Role.new) }

    it "does not allow show" do
      expect(policy.show?).to be_falsey
    end

    it "does not allow create" do
      expect(policy.create?).to be_falsey
    end

    it "does not allow update" do
      expect(policy.update?).to be_falsey
    end

    it "does not allow destroy" do
      expect(policy.destroy?).to be_falsey
    end
  end

  context "for a regular user" do
    let(:user) { User.new }
    let(:policy) { described_class.new(user, Role.new) }

    before do
      allow(user).to receive(:administrador?).and_return(false)
    end

    it "does not allow show" do
      expect(policy.show?).to be_falsey
    end

    it "does not allow create" do
      expect(policy.create?).to be_falsey
    end

    it "does not allow update" do
      expect(policy.update?).to be_falsey
    end

    it "does not allow destroy" do
      expect(policy.destroy?).to be_falsey
    end
  end

  context "for an admin user" do
    let(:user) { User.new }
    let(:policy) { described_class.new(user, Role.new) }

    before do
      allow(user).to receive(:administrador?).and_return(true)
    end

    it "allows show" do
      expect(policy.show?).to be_truthy
    end

    it "allows create" do
      expect(policy.create?).to be_truthy
    end

    it "allows update" do
      expect(policy.update?).to be_truthy
    end

    it "allows destroy" do
      expect(policy.destroy?).to be_truthy
    end
  end
end
