module Spree
  module Admin
    class TodosController < Spree::Admin::BaseController

      def index
        @todos = Todo.all.order(created_at: :desc)
      end

      def new
        @todo = Todo.new
      end


      def create
        @todo = Todo.new(todo_params)
        # authorize @topic

        if @todo.save
          # flash[:success] = "You've successfully created a new topic."
          redirect_to todos_path
        else
          # flash[:danger] = @topic.errors.full_messages
          render new_todo_path
        end
      end


        def edit
          @todo = Todo.find(params[:id])
          # authorize @topic
        end


        def update
          @todo = Todo.find(params[:id])
          # authorize @topic

          #before using Slug use this -> if @topic.update(topic_params)
          if @todo.update(topic_params.merge(slug: topic_params[:title].gsub(" ", "-")))
            flash[:success] = "You've successfully edited the topic."
            redirect_to topics_path
          else
            flash[:danger] = @topic.errors.full_messages
            redirect_to edit_topic_path(@topic)
          end
        end

        def destroy
          @todo = Todo.find(params[:id])
          # authorize @topic

          if @todo.destroy
            # flash[:success] = "You've successfully deleted the topic."
            redirect_to todos_path
          else
            # flash[:danger] = @topic.errors.full_messages
            redirect_to todo_path(@todo)
          end
        end

        private  #to prevent accessible to below info

        def todo_params
          params.require(:todo).permit(:description)
        end


    end
  end
end
