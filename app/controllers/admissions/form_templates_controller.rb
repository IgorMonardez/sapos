# Copyright (c) Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

# frozen_string_literal: true

class Admissions::FormTemplatesController < ApplicationController
  authorize_resource

  active_scaffold "Admissions::FormTemplate" do |config|
    config.list.sorting = { name: "ASC" }
    config.create.label = :create_form_template_label

    config.list.columns = [:name, :description, :template_type]
    config.create.columns = [:name, :description, :template_type, :fields]
    config.update.columns = [:name, :description, :template_type, :fields]

    config.columns[:fields].show_blank_record = false
    config.columns[:template_type].form_ui = :select
    config.columns[:template_type].options = {
      options: Admissions::FormTemplate::TEMPLATE_TYPES
    }

    config.action_links.add "preview",
      label: "<i title='#{
        I18n.t "active_scaffold.admissions/form_template.preview.title"
      }' class='fa fa-play'></i>".html_safe,
      type: :member
    config.actions.exclude :deleted_records
  end
  record_select(
    per_page: 10, search_on: [:name], order_by: "name", full_text_search: true,
    model: "Admissions::FormTemplate"
  )

  def preview
    @form_template = Admissions::FormTemplate.find(params[:id])
    @filled_form = Admissions::FilledForm.new(form_template: @form_template)
    filled_params = filled_form_params
    @notice = nil
    if filled_params.present?
      @filled_form.is_filled = true
      @filled_form.assign_attributes(filled_params)
      if @filled_form.valid?
        @notice = I18n.t("active_scaffold.admissions/form_template.preview.valid")
      end
      @filled_form.is_filled = false
    end
    @filled_form.prepare_missing_fields
  end

  def populate_field
    @scope = params[:scope]
    @parent_record = params[:id].nil? ?
      new_parent_record : find_if_allowed(params[:id], :update)

    if @parent_record.new_record?
      cache_generated_id(@parent_record, params[:generated_id])
    end
    @column = active_scaffold_config.columns[:fields]

    attribute_configs = [
      { name: I18n.t("activerecord.attributes.student.name"),
        field_type: Admissions::FormField::STUDENT_FIELD,
        sync: Admissions::FormField::SYNC_NAME,
        configuration: JSON.dump({ "field": "name", "required": true }) },
      { name: I18n.t("activerecord.attributes.student.cpf"),
        field_type: Admissions::FormField::STUDENT_FIELD,
        configuration: JSON.dump({ "field": "cpf", "required": true }) },
      { name: I18n.t("active_scaffold.admissions/form_template.generate_fields.race_color"),
        field_type: Admissions::FormField::SELECT,
        configuration: JSON.dump({
          "values": I18n.t("active_scaffold.admissions/form_template.generate_fields.race_colors").values
        }) },
      { name: I18n.t("active_scaffold.admissions/form_template.generate_fields.deficiency"),
        field_type: Admissions::FormField::SELECT,
        configuration: JSON.dump({
          "values": I18n.t("active_scaffold.admissions/form_template.generate_fields.deficiencies").values,
          "required": true
        }) },
      { name: I18n.t("activerecord.attributes.student.birthdate"),
        field_type: Admissions::FormField::STUDENT_FIELD,
        configuration: JSON.dump({ "field": "birthdate", "required": true }) },
      { name: I18n.t("activerecord.attributes.student.birth_city"),
        field_type: Admissions::FormField::STUDENT_FIELD,
        configuration: JSON.dump({
          "field": "special_birth_city",
          "required": true
        }) },
      { name: I18n.t("activerecord.attributes.student.identity_number"),
        field_type: Admissions::FormField::STUDENT_FIELD,
        configuration: JSON.dump({ "field": "identity_number", "required": true }) },
      { name: I18n.t("activerecord.attributes.student.identity_issuing_body"),
        field_type: Admissions::FormField::STUDENT_FIELD,
        configuration: JSON.dump({ "field": "identity_issuing_body", "required": true }) },
      { name: I18n.t("activerecord.attributes.student.identity_issuing_place"),
        field_type: Admissions::FormField::STUDENT_FIELD,
        configuration: JSON.dump({ "field": "identity_issuing_place", "required": true }) },
      { name: I18n.t("activerecord.attributes.student.identity_expedition_date"),
        field_type: Admissions::FormField::STUDENT_FIELD,
        configuration: JSON.dump({ "field": "identity_expedition_date", "required": true }) },
      { name: I18n.t("activerecord.attributes.student.sex"),
        field_type: Admissions::FormField::STUDENT_FIELD,
        configuration: JSON.dump({ "field": "sex", "required": true }) },
      { name: I18n.t("activerecord.attributes.student.civil_status"),
        field_type: Admissions::FormField::STUDENT_FIELD,
        configuration: JSON.dump({ "field": "civil_status", "required": true }) },
      { name: I18n.t("activerecord.attributes.student.mother_name"),
        field_type: Admissions::FormField::STUDENT_FIELD,
        configuration: JSON.dump({ "field": "mother_name", "required": true }) },
      { name: I18n.t("activerecord.attributes.student.father_name"),
        field_type: Admissions::FormField::STUDENT_FIELD,
        configuration: JSON.dump({ "field": "father_name" }) },
      { name: I18n.t("active_scaffold.admissions/form_template.generate_fields.contact"),
        field_type: Admissions::FormField::GROUP },
      { name: I18n.t("activerecord.attributes.student.email"),
        field_type: Admissions::FormField::STUDENT_FIELD,
        sync: Admissions::FormField::SYNC_EMAIL,
        configuration: JSON.dump({ "field": "email", "required": true }) },
      { name: I18n.t("active_scaffold.admissions/form_template.generate_fields.cellphone"),
        field_type: Admissions::FormField::STUDENT_FIELD,
        configuration: JSON.dump({ "field": "telephone1", "required": true }) },
      { name: I18n.t("active_scaffold.admissions/form_template.generate_fields.telephone"),
        field_type: Admissions::FormField::STUDENT_FIELD,
        configuration: JSON.dump({ "field": "telephone2" }) },
      { name: I18n.t("active_scaffold.admissions/form_template.generate_fields.address"),
        field_type: Admissions::FormField::GROUP },
      { name: I18n.t("activerecord.attributes.student.city"),
        field_type: Admissions::FormField::STUDENT_FIELD,
        configuration: JSON.dump({
          "field": "special_city",
          "required": true
        }) },
      { name: I18n.t("activerecord.attributes.student.address"),
        field_type: Admissions::FormField::STUDENT_FIELD,
        configuration: JSON.dump({ "field": "special_address", "required": true }) },
      { name: I18n.t("activerecord.attributes.student.zip_code"),
        field_type: Admissions::FormField::STUDENT_FIELD,
        configuration: JSON.dump({ "field": "zip_code", "required": true }) },
      { name: I18n.t("active_scaffold.admissions/form_template.generate_fields.job"),
        field_type: Admissions::FormField::GROUP },
      { name: I18n.t("activerecord.attributes.student.employer"),
        field_type: Admissions::FormField::STUDENT_FIELD,
        configuration: JSON.dump({ "field": "employer" }) },
      { name: I18n.t("activerecord.attributes.student.job_position"),
        field_type: Admissions::FormField::STUDENT_FIELD,
        configuration: JSON.dump({ "field": "job_position" }) },
      { name: I18n.t("active_scaffold.admissions/form_template.generate_fields.scholarity"),
        field_type: Admissions::FormField::STUDENT_FIELD,
        configuration: JSON.dump({
          "field": "special_majors",
          "values": I18n.t("active_scaffold.admissions/form_template.generate_fields.scholarities").values,
          "statuses": I18n.t("active_scaffold.admissions/form_template.generate_fields.scholarity_statuses").values
        }) },
      { name: I18n.t("active_scaffold.admissions/form_template.generate_fields.attachments"),
        description: I18n.t("active_scaffold.admissions/form_template.generate_fields.attachments_description"),
        field_type: Admissions::FormField::GROUP },
      { name: I18n.t("active_scaffold.admissions/form_template.generate_fields.cpf_photo"),
        field_type: Admissions::FormField::FILE,
        configuration: JSON.dump({ "required": true }) },
      { name: I18n.t("active_scaffold.admissions/form_template.generate_fields.identity_photo"),
        field_type: Admissions::FormField::FILE,
        configuration: JSON.dump({ "required": true }) },
      { name: I18n.t("activerecord.attributes.student.photo"),
        field_type: Admissions::FormField::STUDENT_FIELD,
        configuration: JSON.dump({ "field": "photo" }) },
      { name: I18n.t("active_scaffold.admissions/form_template.generate_fields.transcript"),
        field_type: Admissions::FormField::FILE },
      { name: I18n.t("active_scaffold.admissions/form_template.generate_fields.grades_report"),
        field_type: Admissions::FormField::FILE,
        configuration: JSON.dump({ "required": true }) },
    ]

    @records = attribute_configs.collect do |attributes|
      record = build_associated(@column.association, @parent_record)
      record.assign_attributes(attributes)
      record
    end

    respond_to do |format|
      format.js {
        render action: "populate_field",
          formats: [:js],
          readonly: @column.association.readonly?
      }
    end
  end

  private
    def filled_form_params
      params.permit(
        record: Admissions::FilledFormsController.filled_form_params_definition
      )[:record]
    end
end
