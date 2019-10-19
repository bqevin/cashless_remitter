defmodule CashlessRemitter.VendorTest do
  use CashlessRemitter.DataCase

  alias CashlessRemitter.Vendor

  describe "merchants" do
    alias CashlessRemitter.Vendor.Merchant

    @valid_attrs %{
      closing_time: ~T[14:00:00.000000],
      description: "some description",
      logo: "http://some.logo",
      name: "some name",
      opening_time: ~T[14:00:00.000000],
      phone: "+256752235498"
    }
    @update_attrs %{
      closing_time: ~T[15:01:01.000000],
      description: "some updated description",
      logo: "http://some.update.logo",
      name: "some updated name",
      opening_time: ~T[15:01:01.000000],
      phone: "+254724778017"
    }
    @invalid_attrs %{
      closing_time: nil,
      description: nil,
      logo: nil,
      name: nil,
      opening_time: nil,
      phone: nil
    }

    def merchant_fixture(attrs \\ %{}) do
      {:ok, merchant} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Vendor.create_merchant()

      merchant
    end

    test "list_merchants/0 returns all merchants" do
      merchant = merchant_fixture()
      assert Vendor.list_merchants() == [merchant]
    end

    test "get_merchant!/1 returns the merchant with given id" do
      merchant = merchant_fixture()
      assert Vendor.get_merchant!(merchant.id) == merchant
    end

    test "create_merchant/1 with valid data creates a merchant" do
      assert {:ok, %Merchant{} = merchant} = Vendor.create_merchant(@valid_attrs)
      assert merchant.closing_time == ~T[14:00:00.000000]
      assert merchant.description == "some description"
      assert merchant.logo == "http://some.logo"
      assert merchant.name == "some name"
      assert merchant.opening_time == ~T[14:00:00.000000]
      assert merchant.phone == "+256752235498"
    end

    test "create_merchant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Vendor.create_merchant(@invalid_attrs)
    end

    test "update_merchant/2 with valid data updates the merchant" do
      merchant = merchant_fixture()
      assert {:ok, merchant} = Vendor.update_merchant(merchant, @update_attrs)
      assert %Merchant{} = merchant
      assert merchant.closing_time == ~T[15:01:01.000000]
      assert merchant.description == "some updated description"
      assert merchant.logo == "http://some.update.logo"
      assert merchant.name == "some updated name"
      assert merchant.opening_time == ~T[15:01:01.000000]
      assert merchant.phone == "+254724778017"
    end

    test "update_merchant/2 with invalid data returns error changeset" do
      merchant = merchant_fixture()
      assert {:error, %Ecto.Changeset{}} = Vendor.update_merchant(merchant, @invalid_attrs)
      assert merchant == Vendor.get_merchant!(merchant.id)
    end

    test "delete_merchant/1 deletes the merchant" do
      merchant = merchant_fixture()
      assert {:ok, %Merchant{}} = Vendor.delete_merchant(merchant)
      assert_raise Ecto.NoResultsError, fn -> Vendor.get_merchant!(merchant.id) end
    end

    test "change_merchant/1 returns a merchant changeset" do
      merchant = merchant_fixture()
      assert %Ecto.Changeset{} = Vendor.change_merchant(merchant)
    end
  end
end
