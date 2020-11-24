/* eslint-disable no-undef */
/* globals Cypress cy */
describe('CI test for deleting a blog', () => {
  // refactor with a beforeEach for cy.visit command
  it('should create a new blog and click the delete button', () => {
    //  create new blog (to delete later)
    cy.visit(Cypress.env('HOST'));
    cy.get('.navbar').should('be.visible');
    cy.get('.float-right').click({ force: true });
    cy.get('#blogTitle').should('be.visible');
    cy.get('#blogContent').should('be.visible');
    cy.get('#blogTitle').type('Blog to delete');
    cy.get('#blogContent').type('This is the blog to delete');
    cy.get('form > .btn').click({ force: true });

    //  delete the new blog
    cy.get('[href="/blog/Blog to delete"] > h2').should('be.visible').click({ force: true });
    cy.get('.text-left > .btn').click({ force: true });
    cy.get('[href="/blog/Blog to delete"] > h2').should('not.exist');
  });
});
