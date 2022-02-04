export const state = () => ({
    iam: null
})

export const mutations= {
    updateIam(state, iam) {
        state.iam = iam
    }
}