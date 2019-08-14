import {Project, Task} from "../../app/javascript/packs/projects.js"

describe("Projects", () => {
    let project

    beforeEach(() => {
        project = new Project()
        project.appendTask(new Task("Start Project", 1))
        project.appendTask(new Task("Middle Project", 2))
        project.appendTask(new Task("End Project", 3))
    })

    it("can identify the first element of a project", () => {
        expect(project.firstTask().name).toEqual("Start Project")
        expect(project.firstTask().isFirst()).toBeTruthy()
        expect(project.firstTask().isLast()).toBeFalsy()
        expect(project.firstTask().index).toEqual(0)
    })

    it("can identify the last element of a project", () => {
        expect(project.lastTask().name).toEqual("End Project")
        expect(project.lastTask().isLast()).toBeTruthy()
        expect(project.lastTask().isFirst()).toBeFalsy()
        expect(project.lastTask().index).toEqual(2)
    })

    it("can move a task up", () => {
        project.tasks[1].moveUp()
        expect(project.firstTask().name).toEqual("Middle Project")
        expect(project.tasks[1].name).toEqual("Start Project")
        expect(project.lastTask().name).toEqual("End Project")
    })

    it("can move a task down", () => {
        project.tasks[1].moveDown()
        expect(project.firstTask().name).toEqual("Start Project")
        expect(project.tasks[1].name).toEqual("End Project")
        expect(project.lastTask().name).toEqual("Middle Project")
    })

    it("handles asking for the top task to move up", () => {
        project.firstTask().moveUp()
        expect(project.firstTask().name).toEqual("Start Project")
        expect(project.tasks[1].name).toEqual("Middle Project")
        expect(project.lastTask().name).toEqual("End Project")
    })

    it("handles asking for the bottom taks to move up", () => {
        project.lastTask().moveDown()
        expect(project.firstTask().name).toEqual("Start Project")
        expect(project.tasks[1].name).toEqual("Middle Project")
        expect(project.lastTask().name).toEqual("End Project")
    })
})