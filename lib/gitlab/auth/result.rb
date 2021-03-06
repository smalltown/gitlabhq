module Gitlab
  module Auth
    Result = Struct.new(:actor, :project, :type, :authentication_abilities) do
      def ci?(for_project)
        type == :ci &&
          project &&
          project == for_project
      end

      def lfs_deploy_token?(for_project)
        type == :lfs_deploy_token &&
          actor &&
          actor.projects.include?(for_project)
      end

      def success?
        actor.present? || type == :ci
      end
    end
  end
end
