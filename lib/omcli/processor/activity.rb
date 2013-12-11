module OmCli::Processor
  class Activity < OmCli::Processor::Core
    def new(global_options, options, args)
      res = client.create_activity(name: args.first)
      client.workspace_inbox_add(
        user.personal_workspace.id, item_type: "Activity", item_id: res.id
      )
      puts "Activity #{res.name} was successfully created in your personal workspace."
    end

    def list(global_options, options, args)
      res = client.workspace_items(user.personal_workspace.id)
      Formatador.display_table(res.map { |i| i.activity.pick("id", "name", "description") })
    end
  end
end