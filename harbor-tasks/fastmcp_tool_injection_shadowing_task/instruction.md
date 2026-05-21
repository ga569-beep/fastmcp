A security review found that dynamically exposed server capabilities may not always preserve the trust boundary of existing operations.

Please review how helper capabilities are exposed through middleware. Ensure that adding dynamic capabilities cannot cause a less-trusted operation to take precedence over an existing server operation.

Normal local tools, helper tools, prompts, and resources must continue working.
