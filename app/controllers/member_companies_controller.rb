class MemberCompaniesController < ApplicationController
  # GET /member_companies
  # GET /member_companies.json
  def index
    @member_companies = MemberCompany.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @member_companies }
    end
  end

  # GET /member_companies/1
  # GET /member_companies/1.json
  def show
    @member_company = MemberCompany.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @member_company }
    end
  end

  # GET /member_companies/new
  # GET /member_companies/new.json
  def new
    @member_company = MemberCompany.new
    # need to build these so the form knows what to do
    @member_company.build_physical_address
    @member_company.build_mailing_address
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @member_company }
    end
  end

  # GET /member_companies/1/edit
  def edit
    @member_company = MemberCompany.find(params[:id])
  end

  # POST /member_companies
  # POST /member_companies.json
  def create
    @member_company = MemberCompany.new(params[:member_company])

    respond_to do |format|
      if @member_company.save
        format.html { redirect_to @member_company, notice: 'Member company was successfully created.' }
        format.json { render json: @member_company, status: :created, location: @member_company }
      else
        format.html { render action: "new" }
        format.json { render json: @member_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /member_companies/1
  # PUT /member_companies/1.json
  def update
    @member_company = MemberCompany.find(params[:id])

    respond_to do |format|
      if @member_company.update_attributes(params[:member_company])
        format.html { redirect_to @member_company, notice: 'Member company was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @member_company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /member_companies/1
  # DELETE /member_companies/1.json
  def destroy
    @member_company = MemberCompany.find(params[:id])
    @member_company.destroy

    respond_to do |format|
      format.html { redirect_to member_companies_url }
      format.json { head :ok }
    end
  end
end
