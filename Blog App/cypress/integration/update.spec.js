/* eslint-disable no-undef */
/* globals Cypress cy */
describe('CI test for updating a blog', () => {
  // refactor with a beforeEach for cy.visit command
  it('should create a new blog and update its title and content', () => {
    //  create new blog (to update later)
    cy.visit(Cypress.env('HOST'));
    cy.get('.navbar').should('be.visible');
    cy.get('.float-right').click({ force: true });
    cy.get('#blogTitle').should('be.visible');
    cy.get('#blogContent').should('be.visible');
    cy.get('#blogTitle').type('Blog to update');
    cy.get('#blogContent').type('This is the blog to update.');
    cy.get('form > .btn').click({ force: true });

    //  update the blogs title and content
    cy.get('[href="/blog/Blog to update"] > h2').should('be.visible').click({ force: true });
    cy.get(':nth-child(2) > .btn').click({ force: true });
    cy.url().should('include', '/update');
    cy.get('#blogTitle').type(' - UPDATED');
    cy.get('#blogContent').clear();
    cy.get('#blogContent').type('This is the updated blog content');
    cy.get('form > .btn').click({ force: true });
    cy.get('[href="/blog/Blog to update - UPDATED"] > h2').should('be.visible').click({ force: true });
    cy.get('p.text-justify').should('have.text', 'This is the updated blog content');

    //  delete the blog
    cy.get('.text-left > .btn').click({ force: true });
  });
});
