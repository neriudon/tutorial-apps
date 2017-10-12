/*
 * Copyright (C) 2013-2017 NTT DATA Corporation
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
 * either express or implied. See the License for the specific language
 * governing permissions and limitations under the License.
 */
package todo.domain.repository.todo;

import java.util.Collection;

import javax.inject.Inject;

import jp.terasoluna.fw.dao.QueryDAO;
import jp.terasoluna.fw.dao.UpdateDAO;

import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import todo.domain.model.Todo;

@Repository // (1)
@Transactional // (2)
public class TodoRepositoryImpl implements TodoRepository {

    // (3)
    @Inject
    QueryDAO queryDAO;

    @Inject
    UpdateDAO updateDAO;

    // (4)
    @Override
    @Transactional(readOnly = true)
    public Todo findOne(String todoId) {
        return queryDAO.executeForObject("todo.findOne", todoId, Todo.class);
    }

    @Override
    @Transactional(readOnly = true)
    public Collection<Todo> findAll() {
        return queryDAO.executeForObjectList("todo.findAll", null);
    }

    @Override
    public Todo save(Todo todo) {
        // (5)
        if (exists(todo.getTodoId())) {
            updateDAO.execute("todo.update", todo);
        } else {
            updateDAO.execute("todo.create", todo);
        }
        return todo;
    }

    @Transactional(readOnly = true)
    public boolean exists(String todoId) {
        long count = queryDAO.executeForObject("todo.exists", todoId,
                Long.class);
        return count > 0;
    }

    @Override
    public void delete(Todo todo) {
        updateDAO.execute("todo.delete", todo);
    }

    @Override
    @Transactional(readOnly = true)
    public long countByFinished(boolean finished) {
        return queryDAO.executeForObject("todo.countByFinished", finished,
                Long.class);
    }
}
